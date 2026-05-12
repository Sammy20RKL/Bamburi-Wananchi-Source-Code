// namespace BamburiERPSourceCode.BamburiERPSourceCode;

page 58000 "Interest Calculation Report"
{
    ApplicationArea = All;
    Caption = 'Interest Calculation Report';
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = Administration;
    SourceTableView = where("Outstanding Balance" = filter(> 0));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ToolTip = 'Specifies the value of the Loan  No. field.', Comment = '%';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type field.', Comment = '%';
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ToolTip = 'Specifies the value of the Loan Product Type Name field.', Comment = '%';
                }
                field("Client Code"; Rec."Client Code")
                {
                    ToolTip = 'Specifies the value of the Client Code field.', Comment = '%';
                }
                field("Client Name"; Rec."Client Name")
                {
                    ToolTip = 'Specifies the value of the Client Name field.', Comment = '%';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Application Date field.', Comment = '%';
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ToolTip = 'Specifies the value of the Loan Disbursement Date field.', Comment = '%';
                }
                field("Repayment Method"; Rec."Repayment Method") { }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ToolTip = 'Specifies the value of the Approved Amount field.', Comment = '%';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ToolTip = 'Specifies the value of the Outstanding Balance field.', Comment = '%';
                }
                field("Oustanding Interest"; Rec."Oustanding Interest")
                {
                    ToolTip = 'Specifies the value of the Oustanding Interest field.', Comment = '%';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        // Rec.CalcFields("Oustanding Interest");
        //Rec.SetFilter("Oustanding Interest", '<%1', 0);
    end;
}
