#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50494 "Cheque Clearing Header"
{
    PageType = Card;
    SourceTable = "Cheque Clearing Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Entered By"; Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Cleared"; Rec."Expected Date Of Clearing")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cleared  By"; Rec."Cleared  By")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Control1000000002)
            {
                part(StmtLine; "Cheque Clearing Lines")
                {
                    Caption = 'Bank Statement Lines';
                    SubPageLink = "Cheque No" = field(No);
                }
                part(ApplyBankLedgerEntries; "Banking Schedule Cheques")
                {
                    Caption = 'Banked Cheques';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Bank Statement Cheque")
            {
                ApplicationArea = Basic;
                Caption = 'Import Bank Statement Cheque';
                // RunObject = XMLport "susp vendor import";
            }
            group(ActionGroup1102755021)
            {
                // action("Generate Salaries Batch")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Generate Salaries Batch';
                //     RunObject = Report UnknownReport51516289;
                // }
                // action("Generate FOSA Deposits")
                // {
                //     ApplicationArea = Basic;
                //     RunObject = Report UnknownReport39004409;
                // }
                // action("Mark as processed")
                // {
                //     ApplicationArea = Basic;
                //     RunObject = Report UnknownReport39004375;
                // }
                // action("Process Standing Orders")
                // {
                //     ApplicationArea = Basic;
                //     Promoted = false;
                //     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //     //PromotedCategory = New;
                //     RunObject = Report UnknownReport50071;

                //     trigger OnAction()
                //     begin

                //         salarybuffer.Reset;
                //         salarybuffer.SetRange(salarybuffer."Salary Header No.",No);
                //         //salarybuffer.SETRANGE(salarybuffer."Account No.",Sto."Source Account No.");
                //         if salarybuffer.Find('-') then
                //         Report.Run(39004348,true,false,salarybuffer);
                //     end;
                // }
            }
            group(ActionGroup1102755019)
            {
            }
        }
    }

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
        Sto: Record "Standing Orders";
}

