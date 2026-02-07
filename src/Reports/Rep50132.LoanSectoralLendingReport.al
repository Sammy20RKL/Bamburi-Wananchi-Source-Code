#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50132 "Loan Sectoral Lending Report"
{
    RDLCLayout = './Layouts/SECTORALLENDING.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Main Sector"; "Main Sector")
        {
            column(name; CompanyProperty.DisplayName)
            {
            }
            column(Code_MainSector; "Main Sector".Code)
            {
            }
            column(MainSectorAmount; MainSectorAmount)
            {
            }
            column(Description_MainSector; "Main Sector".Description)
            {
            }
            dataitem("Sub Sector"; "Sub Sector")
            {
                DataItemLink = No = field(Code);
                column(Code_SubSector; "Sub Sector".Code)
                {
                }
                column(Description_SubSector; "Sub Sector".Description)
                {
                }
                column(SubSectorAmount; SubSectorAmount)
                {
                }
                dataitem("Specific Sector"; "Specific Sector")
                {
                    DataItemLink = No = field(Code);
                    column(Code_SpecificSector; "Specific Sector".Code)
                    {
                    }
                    column(Description_SpecificSector; "Specific Sector".Description)
                    {
                    }
                    column(AMount; AMount)
                    {
                    }
                    column(startdate; StartDate)
                    {
                    }
                    column(enddate; EndDate)
                    {
                    }
                    column(DateTday; DateTday)
                    {
                    }
                    column(DateTo; DateTo)
                    {
                    }
                    column(FinacialYear; FinacialYear)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        AMount := 0;
                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Specific-Sector", "Specific Sector".Code);
                        LoansR.SetRange(LoansR.Posted, true);
                        LoansR.SetFilter("Issued Date", Datefilter);

                        LoansR.SetFilter("Date filter", '%1..%2', 0D, EndDate);
                        if LoansR.FindFirst() then begin
                            repeat

                                LoansR.CalcFields("Outstanding Balance");
                                AMount := AMount + LoansR."Approved Amount";
                            until LoansR.Next = 0;
                        end;
                    end;

                }

                trigger OnAfterGetRecord();
                begin
                    SubSectorAmount := 0;
                    LoansR.Reset;
                    LoansR.SetRange(LoansR."Sub-Sector", "Sub Sector".Code);
                    LoansR.SetRange(LoansR.Posted, true);
                    LoansR.SetFilter("Issued Date", Datefilter);
                    LoansR.SetFilter("Date filter", '%1..%2', 0D, EndDate);
                    if LoansR.FindFirst() then begin
                        repeat


                            LoansR.CalcFields("Outstanding Balance");
                            SubSectorAmount := SubSectorAmount + LoansR."Approved Amount";
                        until LoansR.Next = 0;
                    end;
                end;
            }
            trigger OnAfterGetRecord();
            begin
                MainSectorAmount := 0;
                LoansR.Reset;
                LoansR.SetRange(LoansR."Main-Sector", "Main Sector".Code);
                LoansR.SetRange(LoansR.Posted, true);
                LoansR.SetFilter("Issued Date", Datefilter);
                LoansR.SetFilter("Date filter", '%1..%2', 0D, EndDate);
                if LoansR.FindFirst() then begin
                    repeat

                        LoansR.CalcFields("Outstanding Balance");
                        MainSectorAmount := MainSectorAmount + LoansR."Approved Amount";
                    until LoansR.Next = 0;
                end;
            end;
        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending Date';
                }

            }
        }

        actions
        {
        }

    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        Datefilter := Format(StartDate) + '..' + Format(EndDate);
        GenLedgerSetup.Get();
        DateTday := Format(GenLedgerSetup."Allow Posting From");
        DateTo := Format(GenLedgerSetup."Allow Posting To");
        FinacialYear := Date2dmy(StartDate, 3);

    end;

    var
        LoansR: Record "Loans Register";
        AMount: Decimal;
        StartDate: Date;
        EndDate: Date;
        Datefilter: Text;
        GenLedgerSetup: Record "General Ledger Setup";
        DateTday: Text;
        DateTo: Text;
        FinacialYear: Integer;
        SubSectorAmount: Decimal;
        MainSectorAmount: Decimal;
}
