report 56891 "Loan Repayment Schedules"
{
    Caption = 'Loan Repayment Schedules';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Loan Disbursement Date", "Client Code";
            DataItemTableView = sorting("Loan  No.") where(Posted = const(true));

            trigger OnPreDataItem()
            begin
                SetFilter("Approved Amount", '>%1', 0);
                SetFilter("Repayment Start Date", '<>%1', 0D);
                SetFilter("Loan Disbursement Date", '<>%1', 0D);
                SetFilter(Installments, '>%1', 0);

                TotalProcessed := 0;
                TotalSkipped := 0;
            end;

            trigger OnAfterGetRecord()
            var
                RSchedule: Record "Loan Repayment Schedule";
            begin
                // Check if schedule exists
                RSchedule.Reset();
                RSchedule.SetRange("Loan No.", "Loan  No.");

                if RSchedule.FindFirst() and (not RegenerateExisting) then begin
                    TotalSkipped += 1;
                    exit;
                end;

                // Delete if regenerating
                if RegenerateExisting then begin
                    RSchedule.DeleteAll();
                end;


                SFactory.FnGenerateRepaymentSchedule("Loan  No.");

                TotalProcessed += 1;
            end;

            trigger OnPostDataItem()
            begin
                Message(
                    'Completed.\' +
                    'Processed : %1\' +
                    'Skipped   : %2',
                    TotalProcessed,
                    TotalSkipped
                );
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(RegenerateExisting; RegenerateExisting)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Regenerate Existing';
                    }
                }
            }
        }
    }

    var
        SFactory: Codeunit "Swizzsoft Factory";
        RegenerateExisting: Boolean;
        TotalProcessed: Integer;
        TotalSkipped: Integer;
}