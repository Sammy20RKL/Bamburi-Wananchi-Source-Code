#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51591 "Generate Monthly Interest Nav"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance", "Oustanding Interest";
            DataItemTableView = where("Pays Interest During GP" = filter(false));
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Client Code", "Loan Disbursement Date";
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*IF "Loans Register"."Loan Product Type"='HISTORICAL' THEN
                   CurrReport.SKIP;*/
                //MESSAGE('Datetetet1 %1',BillDate);
                if "Loans Register"."Repayment Start Date" > BillDate then
                    CurrReport.Skip;
                //MESSAGE('Datetetet2 %1',BillDate);
                NoOfRecords := "Loans Register".Count;
                dWindow.Update(2, NoOfRecords);

                dWindow.Update(1, "Loans Register"."Client Name");
                CurrentRecordNo += 1;
                Exception := false;

                if "Loans Register"."Loan Product Type" = '24' then
                    CurrReport.Skip;

                if ProdFact.Get("Loans Register"."Loan Product Type") then begin
                    //MESSAGE('prod %1',"Loans Register"."Loan Product Type");
                    if "Loans Register".Interest <> ProdFact."Interest rate" then begin
                        "Loans Register".Interest := ProdFact."Interest rate";
                        "Loans Register".Modify;
                    end;
                    if ProdFact."Interest Calculation Method" = ProdFact."interest calculation method"::"Flat Rate" then begin
                        if BillDate <= "Loans Register"."Expected Date of Completion" then begin
                            if "Loans Register"."Interest Calculation Method" <> "Loans Register"."interest calculation method"::"Flat Rate" then begin
                                "Loans Register"."Interest Calculation Method" := "Loans Register"."interest calculation method"::"Flat Rate";
                                "Loans Register".Modify;
                                Commit;
                            end;
                        end
                        else begin
                            if "Loans Register"."Interest Calculation Method" <> "Loans Register"."interest calculation method"::"Reducing Balances" then begin
                                "Loans Register"."Interest Calculation Method" := "Loans Register"."interest calculation method"::"Reducing Balances";
                                "Loans Register".Modify;
                                Commit;
                            end;
                        end;
                    end;

                end;


                Periodic.GenerateLoanMonthlyInterest2("Loans Register"."Loan  No.", BillDate);

                dWindow.Update(3, CurrentRecordNo);
                dWindow.Update(4, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

            end;

            trigger OnPostDataItem()
            begin
                //dWindow.CLOSE;
                /*IF Options = Options::"Generate & Post" THEN BEGIN
                    InterestHeader.RESET;
                    InterestHeader.SETRANGE("No.",'INTEREST');
                    IF InterestHeader.FINDFIRST THEN BEGIN
                        Periodic.PostLoanInterest(InterestHeader);
                    END;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin


                dWindow.Open('Generating Interest:                #1#########\'
                                    + 'Total Loans:                #2#########\'
                                    + 'Counter:                    #3#########\'
                                    + 'Progress:                   @4@@@@@@@@@\'
                                    + 'Press Esc to abort');


                if BillDate = 0D then
                    BillDate := Today;


                //BillDate:=CALCDATE('-CM',BillDate);
                //BillDate:=CALCDATE('CM',TODAY);
                //MESSAGE('Datetetet %1',BillDate);

                //Loans.SETFILTER("Date Filter",'..%1',CALCDATE('-1M+CM',BillDate));
                //Loans.SETFILTER("Outstanding Balance",'>0');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Billing Date"; BillDate)
                {
                    ApplicationArea = Basic;
                }
                field(Options; Options)
                {
                    ApplicationArea = Basic;
                    Caption = 'Options';
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

    trigger OnInitReport()
    begin
        //Options:=Options::"Generate & Post";
    end;

    var
        LoanType: Record "Loan Products Setup";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        LoansCaptionLbl: label 'Loans';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        "Document No.": Code[20];
        // RecBuffer: Record UnknownRecord51516296;
        // RecBuffLines: Record UnknownRecord51516295;
        LoanAmount: Decimal;
        CustMember: Record Vendor;
        Text001: label 'Document No. Must be equal to No.';
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        // RecBuffers: Record UnknownRecord51516296;
        // LoansInterest: Record UnknownRecord51516295;
        IntCharged: Decimal;
        Principle: Decimal;
        // SuspendedInterestAccounts: Record UnknownRecord51516298;
        MonthDays: Integer;
        // InterestDuePeriod: Record UnknownRecord51516391;
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        Periodic: Codeunit "Periodic Activities";
        BillDate: Date;
        Exception: Boolean;
        ProdFact: Record "Loan Products Setup";
        Options: Option "Generate Only","Generate & Post";
    // InterestHeader: Record UnknownRecord51516296;
}

