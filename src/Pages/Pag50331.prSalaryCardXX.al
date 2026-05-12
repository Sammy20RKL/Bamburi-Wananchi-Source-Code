#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50331 "prSalary CardXX"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "prSalary Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Payment Info';
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = Basic;
                }
                field("Pays NSSF"; Rec."Pays NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NHIF"; Rec."Pays NHIF")
                {
                    ApplicationArea = Basic;
                }
                field("Pays PAYE"; Rec."Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Pays Pension"; Rec."Pays Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm BasicPay"; Rec."Cumm BasicPay")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm GrossPay"; Rec."Cumm GrossPay")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm NetPay"; Rec."Cumm NetPay")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm Allowances"; Rec."Cumm Allowances")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm Deductions"; Rec."Cumm Deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Period Filter"; Rec."Period Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm PAYE"; Rec."Cumm PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm NSSF"; Rec."Cumm NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm Pension"; Rec."Cumm Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm HELB"; Rec."Cumm HELB")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm NHIF"; Rec."Cumm NHIF")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm Employer Pension"; Rec."Cumm Employer Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Pay"; Rec."Suspend Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Suspension Date"; Rec."Suspension Date")
                {
                    ApplicationArea = Basic;
                }
                field("Suspension Reasons"; Rec."Suspension Reasons")
                {
                    ApplicationArea = Basic;
                }
                field("Fosa Accounts"; Rec."Fosa Accounts")
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

