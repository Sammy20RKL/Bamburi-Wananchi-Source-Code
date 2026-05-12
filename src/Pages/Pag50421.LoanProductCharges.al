#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50421 "Loan Product Charges"
{
    PageType = List;
    SourceTable = "Loan Product Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = Basic;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic;
                }
                field("Use Perc"; Rec."Use Perc")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Deduction Type"; Rec."Deduction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Charge Type"; Rec."Loan Charge Type")
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

