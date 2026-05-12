#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50238 "Other Commitments Clearance"
{
    PageType = List;
    SourceTable = 51403;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Bankers Cheque No"; Rec."Bankers Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field("Bankers Cheque No 2"; Rec."Bankers Cheque No 2")
                {
                    ApplicationArea = Basic;
                }
                field("Bankers Cheque No 3"; Rec."Bankers Cheque No 3")
                {
                    ApplicationArea = Basic;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                }
                field("Affects 2/3 Rule"; Rec."Affects 2/3 Rule")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Deductions"; Rec."Monthly Deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Account"; Rec."Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Member Loan Account"; Rec."Member Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Clearance"; Rec."Loan Clearance")
                {
                    ApplicationArea = Basic;
                }
                field("Total Loan Balance"; Rec."Total Loan Balance")
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

