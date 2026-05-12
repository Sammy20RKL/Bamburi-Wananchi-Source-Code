#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50324 "Payroll Employee Assignments."
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Employee.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Firstname; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Lastname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pays PAYE"; Rec."Pays PAYE")
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
                field(Secondary; Rec.Secondary)
                {
                    ApplicationArea = Basic;
                }
            }
            group(Numbers)
            {
                field("National ID No"; Rec."National ID No")
                {
                    ApplicationArea = Basic;
                }
                field("PIN No"; Rec."PIN No")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF No"; Rec."NHIF No")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF No"; Rec."NSSF No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("PAYE Relief and Benefit")
            {
                field(GetsPayeRelief; Rec.GetsPayeRelief)
                {
                    ApplicationArea = Basic;
                }
                field(GetsPayeBenefit; Rec.GetsPayeBenefit)
                {
                    ApplicationArea = Basic;
                }
                field(PayeBenefitPercent; Rec.PayeBenefitPercent)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Employee Company")
            {
                field(Company; Rec.Company)
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

