#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50479 "Loan Guarantors FOSA"
{
    PageType = ListPart;
    SourceTable = "Loan GuarantorsFOSA";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No."; Rec."Staff/Payroll No.")
                {
                    ApplicationArea = Basic;
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Guaranted"; Rec."Amount Guaranted")
                {
                    ApplicationArea = Basic;
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Self Guarantee"; Rec."Self Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Salaried; Rec.Salaried)
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

