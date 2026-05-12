#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50936 "Loan Batch Lines"
{
    PageType = ListPart;
    SourceTable = "Loan Dis Batch Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mode Of Disbursement"; Rec."Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Disburse"; Rec."Amount to Disburse")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Fees"; Rec."EFT Fees")
                {
                    ApplicationArea = Basic;
                }
                field(Unallocated; Rec.Unallocated)
                {
                    ApplicationArea = Basic;
                }
                field("Available Amount"; Rec."Available Amount")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

