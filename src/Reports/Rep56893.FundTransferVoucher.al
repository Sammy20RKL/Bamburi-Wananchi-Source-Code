report 56893 "Funds Transfer Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/FundsTransferVoucher.rdlc';
    Caption = 'Funds Transfer Voucher';
    ApplicationArea = All;

    dataset
    {
        dataitem(FundsTransferHeader; "Funds Transfer Header")
        {
            RequestFilterFields = "No.", "Posting Date", "Paying Bank Account";

            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo."Address 2")
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(ReportTitle; 'FUNDS TRANSFER VOUCHER')
            {
            }
            column(PrintedBy; UserId())
            {
            }
            column(PrintedDate; Today())
            {
            }
            column(PrintedTime; Time())
            {
            }
            // Header Fields
            column(No; "No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(PayMode; "Pay Mode")
            {
            }
            column(PayingBankAccount; "Paying Bank Account")
            {
            }
            column(PayingBankName; "Paying Bank Name")
            {
            }
            column(BankAccountNo; "Bank Account No.")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(AmountToTransfer; "Amount to Transfer")
            {
            }
            column(AmountToTransferLCY; "Amount to Transfer(LCY)")
            {
            }
            column(TotalLineAmount; "Total Line Amount")
            {
            }
            column(TotalLineAmountLCY; "Total Line Amount(LCY)")
            {
            }
            column(Description; Description)
            {
            }
            column(ChequeDocNo; "Cheque/Doc. No")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(Status; Status)
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(DateCreated; "Date Created")
            {
            }
            column(TimeCreated; "Time Created")
            {
            }
            column(TransferType; "Transfer Type")
            {
            }
            // Draft Watermark - since this prints before posting
            column(IsDraft; IsDraftText)
            {
            }

            dataitem(FundsTransferLine; "Funds Transfer Line")
            {
                DataItemLink = "Document No" = field("No.");
                DataItemTableView = sorting("Document No", "Line No");

                column(LineNo; "Line No")
                {
                }
                column(DocumentNo; "Document No")
                {
                }
                column(ReceivingBankAccount; "Receiving Bank Account")
                {
                }
                column(ReceivingBankName; "Bank Name")
                {
                }
                column(ReceivingAccountNo; "Bank Account No.")
                {
                }
                column(AmountToReceive; "Amount to Receive")
                {
                }
                column(AmountToReceiveLCY; "Amount to Receive (LCY)")
                {
                }


            }

            trigger OnAfterGetRecord()
            begin
                // Prevent printing if already posted
                //if Posted then
                //   Error('This document has already been posted. Use the Posted Funds Transfer Voucher report instead.');

                // Calc Flow Fields
                CalcFields("Total Line Amount", "Total Line Amount(LCY)", "Bank Balance");

                // Set Draft watermark text
                IsDraftText := 'DRAFT - NOT POSTED';
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
                    Caption = 'Options';
                    field(ShowDraftWatermark; ShowDraftWatermark)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Draft Watermark';
                        ToolTip = 'Check to print DRAFT watermark on the voucher.';
                    }
                }
            }
        }
    }

    labels
    {
        // Header Labels
        LblFundsTransferVoucher = 'FUNDS TRANSFER VOUCHER';
        LblVoucherNo = 'Voucher No.';
        LblDocumentDate = 'Document Date';
        LblPostingDate = 'Posting Date';
        LblPayMode = 'Payment Mode';
        LblPayingBank = 'Paying Bank';
        LblBankName = 'Bank Name';
        LblCurrency = 'Currency';
        LblAmountToTransfer = 'Amount to Transfer';
        LblAmountToTransferLCY = 'Amount to Transfer (LCY)';
        LblTotalLineAmount = 'Total Line Amount';
        LblDescription = 'Description / Narration';
        LblChequeDocNo = 'Cheque / Doc No.';
        LblBranch = 'Branch';
        LblStatus = 'Status';
        LblCreatedBy = 'Prepared By';
        LblDateCreated = 'Date Prepared';

        // Line Labels
        LblLineNo = 'Line No.';
        LblReceivingBank = 'Receiving Bank';
        LblReceivingBankName = 'Receiving Bank Name';
        LblReceivingAccountNo = 'Account No.';
        LblAmountToReceive = 'Amount to Receive';
        LblLineDescription = 'Description';

        // Signature Labels
        LblPreparedBy = 'Prepared By: ____________________________';
        LblCheckedBy = 'Checked By:  ____________________________';
        LblApprovedBy = 'Approved By: ____________________________';
        LblSignature = 'Signature:     ____________________________';
        LblDate = 'Date:              ____________________________';

        // Footer
        LblPrintedBy = 'Printed By';
        LblPrintedDate = 'Printed Date';
        LblPrintedTime = 'Printed Time';
        LblDraft = 'DRAFT - NOT POSTED';
    }

    var
        IsDraftText: Text;
        CompanyInfo: Record "Company Information";
        ShowDraftWatermark: Boolean;

    trigger OnInitReport()
    begin
        ShowDraftWatermark := true;
    end;
}
