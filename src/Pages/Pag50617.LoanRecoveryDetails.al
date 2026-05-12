#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50617 "Loan Recovery Details"
{
    PageType = ListPart;
    SourceTable = "Loan Member Loans";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Guarantor Number"; Rec."Guarantor Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("phone No"; Rec."phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Repayment"; Rec."Monthly Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Outstanding"; Rec."Loan Outstanding")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Guarantor Deposits"; Rec."Guarantor Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Defaulter Loan"; Rec."Defaulter Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Trustee Loan';
                    Editable = false;
                }
                field("Amount to Trustee Loan"; Rec."Amount to Trustee Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Origan Amount"; Rec."Origan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amont Guaranteed"; Rec."Amont Guaranteed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Per(%)"; Rec."Per(%)")
                {
                    ApplicationArea = Basic;
                }
                field(PayOff; Rec.PayOff)
                {
                    ApplicationArea = Basic;
                    Caption = 'PayOff Amount';
                }
                field("Amount from Deposits"; Rec."Amount from Deposits")
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

