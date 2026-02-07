#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 56521 "Process Holiday Savings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Process Holiday Savings.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Holiday Savings";
            DataItemTableView = where("Holiday Savings" = filter(> 0));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Members.Reset;
                Members.SetRange(Members."No.", Customer."No.");
                if Members.Find('-') then begin
                    repeat
                        HolidaySavingsProcessing.FnProcessHolidaySavings(Members."No.", StartDate, PostingDate);
                    until Members.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Successfully Generated');

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'HOLIDAY');
                if GenJournalLine.Find('-') then
                    page.Run(Page::"General Journal", GenJournalLine);
            end;

            trigger OnPreDataItem()
            begin
                HolidayTable.Reset;
                if HolidayTable.Find('-') then begin
                    HolidayTable.DeleteAll();
                end;
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'HOLIDAY');
                if GenJournalLine.Find('-') then begin
                    GenJournalLine.DeleteAll();
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'PostingDate';
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

    trigger OnPreReport()
    begin
        SaccoGeneralSetUp.Get();
        SaccoGeneralSetUp.TestField("HolidaySavings Payout Bank");

        if PostingDate = 0D then Error('Posting Date MUST be Specified');
        if StartDate = 0D then Error('Start Date MUST be Specified');
    end;

    var
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
        HolidaySavingsProcessing: Codeunit "Holiday Savings Codeunit";
        Members: Record Customer;
        PostingDate: Date;
        StartDate: Date;
        HolidayTable: Record "Holiday Savings Table";
        GenJournalLine: Record "Gen. Journal Line";
}

