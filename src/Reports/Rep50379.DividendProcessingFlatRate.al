Report 50379 "Dividend Processing-Flat Rate"

{
    ApplicationArea = All;
    Caption = 'Dividend Processing-Flat Rate';
    UsageCategory = Tasks;

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Dividend Processing-Flat Rate.rdlc';

    dataset

    {

        dataitem(Customer; Customer)
        {
            DataItemTableView = sorting("No.") where("No." = filter(<> ''));
            RequestFilterFields = "No.", Status;
            column(No; "No.")
            {

            }

            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                CustomerTable.Reset();
                CustomerTable.SetRange(CustomerTable."No.", Customer."No.");
                if CustomerTable.find('-') then begin
                    repeat
                    //DividendsPorcessingCodeUnit.FnProcessDividendsFlatRate(Customer."No.", StartDate, EndDate);
                    until CustomerTable.next = 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Dividend Processing Periods")
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
        }
        actions
        {
            area(processing)
            {
            }

        }

    }
    labels
    {
    }

    trigger OnInitReport()
    var
        PermissionDenied: Label 'Denied! You need neccessary permissions to perform this action';
    begin
        //................Check if you have the neccessary permissions to run report
        if UserSetUp.Get(UserId) then begin
            if not UserSetUp."User Can Process Dividends" then begin
                Error(PermissionDenied);
            end;
        end;
        //................AutoPopolate Dates on report
        if StartDate = 0D THEN begin
            StartDate := DMY2DATE(1, 1, (DATE2DMY((Today), 3) - 1));
        end Else
            if StartDate <> 0D then begin
                StartDate := StartDate;
            end;

        if EndDate = 0D THEN begin
            EndDate := DMY2DATE(31, 12, (DATE2DMY((Today), 3) - 1));
        end Else
            if EndDate <> 0D then begin
                EndDate := EndDate;
            end;
    end;

    trigger OnPreReport()
    begin
        if StartDate = 0D THEN begin
            StartDate := DMY2DATE(1, 1, DATE2DMY((Today) - 1, 3));
        end Else
            if StartDate <> 0D then begin
                StartDate := StartDate;
            end;

        if EndDate = 0D THEN begin
            EndDate := DMY2DATE(31, 12, DATE2DMY((Today) - 1, 3));
        end Else
            if EndDate <> 0D then begin
                EndDate := EndDate;
            end;
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'DIVIDEND');
        GenJournalLine.DeleteAll;
    end;

    trigger OnPostReport()
    begin
        //....................Post Dividends Code start

        //....................Post Dividends Code end
    end;

    var
        StartDate: date;
        EndDate: date;
        UserSetUp: Record "User Setup";
        //  DividendsPorcessingCodeUnit: Codeunit "Dividends Processing-Flat Rate";
        CustomerTable: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
}
