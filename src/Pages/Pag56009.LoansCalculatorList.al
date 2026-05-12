#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 56009 "Loans Calculator List"
{
    ApplicationArea = Basic;
    CardPageID = "Loans Calculator";
    Editable = false;
    PageType = List;
    SourceTable = "Loans Calculator";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
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

