Report 50251 "Dividends Payments"
{
    Caption = 'Dividends Payments';
    ProcessingOnly = true;
    ApplicationArea = all;
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.") { }
            trigger OnPreDataItem();
            begin



                BATCH_TEMPLATE := 'PAYMENTS';
                BATCH_NAME := 'DIVIDEND';
                DOCUMENT_NO := 'DIV_' + FORMAT(PostingDate);
                ObjGensetup.GET();
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SETRANGE("Journal Batch Name", BATCH_NAME);
                GenJournalLine.DELETEALL;
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Cust.Reset();
                Cust.SetRange(Cust."No.", "No.");
                cust.SetFilter(cust."Retaine Dividends", '%1', false);
                if cust.FindSet() then begin

                    Cust.CalcFields(Cust."Dividend Amount");
                    if cust."Dividend Amount" > 0 then begin
                        repeat
                            ObjGensetup.GET();
                            DivTotal := cust."Dividend Amount";
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."Transaction Type"::Dividend,
                            GenJournalLine."Account Type"::Customer, "No.", PostingDate, DivTotal, 'BOSA', '',
                            'Dividends Payments- ' + FORMAT(PostingDate), '', GenJournalLine."Account Type"::"Bank Account", ObjGensetup."Dividends Paying Bank Account");

                        until Cust.Next = 0;

                    end;


                end;
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                if GenJournalLine.Find('-') then
                    Page.Run(page::"General Journal", GenJournalLine);
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
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = all;
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
    var
        cust: Record Customer;
        ObjGensetup: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "SWIZZSFT Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[50];
        LineNo: Integer;
        PostingDate: Date;
        DivTotal: Decimal;
}
