#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 56894 "Process Dividends for member2"
{
    ProcessingOnly = true;
    // DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/Process Dividends for member.rdlc';

    dataset
    {
        dataitem("Member Register"; Customer)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                EndOfLastYear: Date;
                CutoffDate: Date;
            begin
                EndOfLastYear := DMY2Date(31, 12, Date2DMY(Today, 3) - 1);
                CutoffDate := CalcDate('-3M', EndOfLastYear);

                MembersReg.Reset;
                MembersReg.SetRange(MembersReg."No.", "Member Register"."No.");
                MembersReg.SetAutocalcFields(MembersReg."Shares Retained");
                MembersReg.SetFilter("Date of Registration", '<=%1', CutoffDate);
                if MembersReg.Find('-') then begin
                    repeat
                        FnDividendsCodeUnit.FnAnalyseMemberCategory(MembersReg."No.", StartDate, PostingDate);
                    until MembersReg.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                //Autopost entries to the relevant accounts
                /*
                 GenJournalLine.RESET;
                 GenJournalLine.SETRANGE("Journal Template Name",'PAYMENTS');
                 GenJournalLine.SETRANGE("Journal Batch Name",'DIVIDEND');
                 IF GenJournalLine.FIND('-') THEN BEGIN
                 CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
                 END;
                 */
                Message('Journals Created Successfully');
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                GenJournalLine.SetRange("Journal Batch Name", 'DIVIDEND');
                if GenJournalLine.Find('-') then
                    page.Run(Page::"General Journal", GenJournalLine);
            end;

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then begin
                    Error('You Must specify the starting Date');
                end;
                if PostingDate = 0D then begin
                    PostingDate := Today;
                end;

                //...........................
                MembersReg.Reset;
                //MembersReg.ModifyAll(MembersReg."Dividend Amount", 0);
                MembersReg.Reset;
                MembersReg.ModifyAll(MembersReg."Gross Dividend Amount Payable", 0);

                BATCH_TEMPLATE := 'PAYMENTS';
                BATCH_NAME := 'DIVIDEND';
                DOCUMENT_NO := Format(PostingDate);
                ObjGensetup.Get();
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then begin
                    GenJournalLine.DeleteAll;
                end;



                // Dividends_Posting_Breakdown.Reset();
                // Dividends_Posting_Breakdown.SetRange("Member Number");
                // if Dividends_Posting_Breakdown.Find('-') then begin
                //     Dividends_Posting_Breakdown.DeleteAll();
                // end;
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
                    Caption = 'Starting Date';
                }
                field(PostingDate; PostingDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
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
        StartDate := Dmy2date(1, 1, (Date2dmy(Today, 3) - 1));
    end;

    var
        MembersReg: Record Customer;
        FnDividendsCodeUnit: Codeunit "Dividends Processing Codeunit2";
        StartDate: Date;
        PostingDate: Date;
        ObjGensetup: Record "General Ledger Setup";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        Dividends_Posting_Breakdown: Record "Dividends Posting Breakdown";
}

