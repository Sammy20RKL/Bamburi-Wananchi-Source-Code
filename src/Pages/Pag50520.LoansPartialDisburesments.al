#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
page 50520 "Loans Partial Disburesments"
{
    PageType = List;
    SourceTable = "Loan Partial Disburesments";

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
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product"; Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Be Disbursed"; Rec."Amount to Be Disbursed")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Due"; Rec."Amount Due")
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

